package business.order;

import business.BookstoreDbException;
import business.JdbcUtils;
import business.book.Book;
import business.book.BookDao;
import business.cart.ShoppingCart;
import business.cart.ShoppingCartItem;
import business.customer.Customer;
import business.customer.CustomerDao;
import business.customer.CustomerForm;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.function.Function;
import java.util.stream.Collectors;

public class DefaultOrderService implements OrderService {

    private OrderDao orderDao;
    private LineItemDao lineItemDao;
    private CustomerDao customerDao;
    private BookDao bookDao;
    private Random random = new Random();

    @Override
    public long placeOrder(CustomerForm form, ShoppingCart cart) {

        try (Connection connection = JdbcUtils.getConnection()) {
            return performPlaceOrderTransaction(form.getName(), form.getAddress(), form.getPhone(), form.getEmail(),
                    form.getCcNumber(), form.getCcExpDate(), cart, connection);
        } catch (SQLException e) {
            throw new BookstoreDbException("Error during close connection for customer order", e);
        }
    }

    private final Function<LineItem, Book> LINE_ITEM_TO_BOOK =
            (lineItem) -> bookDao.findByBookId(lineItem.getBookId());

    @Override
    public OrderDetails getOrderDetails(long customerOrderId) {
        try {
            Order order = orderDao.findByCustomerOrderId(customerOrderId);
            Customer customer = customerDao.findByCustomerId(order.getCustomerId());
            List<LineItem> lineItems = new ArrayList<>(lineItemDao.findByCustomerOrderId(customerOrderId));
            List<Book> books = lineItems
                    .stream()
                    .map(LINE_ITEM_TO_BOOK)
                    .collect(Collectors.toList());

            return new OrderDetails(order, customer, lineItems, books);
        } catch (Exception e) {
            throw new BookstoreDbException("Trouble getting order details.", e);
        }
    }



    private long performPlaceOrderTransaction(String name, String address, String phone, String email,
                                              String ccNumber, Date ccExpDate, ShoppingCart cart,
                                              Connection connection) {
        try {
            connection.setAutoCommit(false);

            long customerId = customerDao.create(connection, name, address, phone, email, ccNumber, ccExpDate);
            long customerOrderId = orderDao.create(connection, cart.getSubtotal() + cart.getSurcharge(), generateConfirmationNumber(), customerId);
            for (ShoppingCartItem item : cart.getItems()) {
                lineItemDao.create(connection, customerOrderId, item.getBookId(), item.getQuantity());
            }
            connection.commit();
            return customerOrderId;
        } catch (Exception e) {
            try {
                connection.rollback();
            } catch (SQLException e1) {
                throw new BookstoreDbException("Failed to roll back transaction", e1);
            }
            return 0;
        }
    }

    public String maskString(String strText, int start, int end, char maskChar)
            throws Exception{

        if(strText == null || strText.equals(""))
            return "";

        if(start < 0)
            start = 0;

        if( end > strText.length() )
            end = strText.length();

        if(start > end)
            throw new Exception("End index cannot be greater than start index");

        int maskLength = end - start;

        if(maskLength == 0)
            return strText;

        StringBuilder sbMaskString = new StringBuilder(maskLength);

        for(int i = 0; i < maskLength; i++){
            sbMaskString.append(maskChar);
        }

        return strText.substring(0, start)
                + sbMaskString.toString()
                + strText.substring(start + maskLength);
    }


    private int generateConfirmationNumber() {
        return random.nextInt(999999999);
    }

    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }

    public void setLineItemDao(LineItemDao lineItemDao) {
        this.lineItemDao = lineItemDao;
    }

    public void setCustomerDao(CustomerDao customerDao) {
        this.customerDao = customerDao;
    }

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

}
