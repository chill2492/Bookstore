package viewmodel;

import business.ApplicationContext;
import business.book.BookDao;
import business.category.Category;
import business.cart.ShoppingCart;
import business.category.CategoryDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

public class BaseViewModel {

    private static final String SITE_IMAGE_PATH = "images/site/";
    private static final String BOOK_IMAGE_PATH = "images/books/";


    protected HttpServletRequest request;
    protected HttpSession session;


    private List<Category> categories;
    private ShoppingCart cart;

    private int checkoutSurcharge;

    public BaseViewModel(HttpServletRequest request) {
        this.request = request;
        this.session = request.getSession(true);
        this.categories = initCategories();
        this.cart = initCart();
        this.checkoutSurcharge = 500;
    }

    private List<Category> initCategories() {
        List<Category> result = (List<Category>) request.getServletContext().getAttribute("categories");
        if (result == null) {
            result = ApplicationContext.INSTANCE.getCategoryDao().findAll();
            request.getServletContext().setAttribute("categories", result);
        }
        return result;
    }

    private ShoppingCart initCart() {
        ShoppingCart result = (ShoppingCart) session.getAttribute("cart");
        if (result == null) {
            result = new ShoppingCart();
            session.setAttribute("cart", result);
        }
        return result;
    }

    public int getCheckoutSurcharge() {

        return checkoutSurcharge;

    }

    public String getSiteImagePath() {
        return SITE_IMAGE_PATH;
    }

    public String getBookImagePath() {
        return BOOK_IMAGE_PATH;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public ShoppingCart getCart() {
        return cart;
    }

    public Category getSelectedCategory() {
        return (Category) session.getAttribute("selectedCategory");
    }




}