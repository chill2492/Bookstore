package viewmodel;

import business.cart.ShoppingCart;
import business.order.OrderDetails;

import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ConfirmationViewModel extends BaseViewModel {

    private OrderDetails orderDetails;
    private int surcharge;

    public ConfirmationViewModel(HttpServletRequest request) {
        super(request);

        orderDetails = (OrderDetails) session.getAttribute("orderDetails");
        session.setAttribute("orderDetails", null);

        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        surcharge = cart.getSurcharge();
    }

    public OrderDetails getOrderDetails(){return orderDetails;}

    public int getSurcharge(){return surcharge;}

    public String getOrderDateForDisplay() {

        String pattern = "(MM/yy)";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

        String date = simpleDateFormat.format(orderDetails.getCustomer().getCcExpDate());
        return date;
    }
}
