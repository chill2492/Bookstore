package viewmodel;

import business.ApplicationContext;
import business.book.Book;
import business.book.BookDao;
import business.category.Category;
import business.category.CategoryDao;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public class HomepageViewModel extends BaseViewModel {

    private Category bestSeller;
    private Category topRated;
    private Category newReleases;

    private List<Book> selectedBestSellerBooks;
    private List<Book> selectedTopRatedBooks;
    private List<Book> selectedNewReleasesBooks;

    BookDao bookDao = ApplicationContext.INSTANCE.getBookDao();
    CategoryDao categoryDao = ApplicationContext.INSTANCE.getCategoryDao();

    public HomepageViewModel(HttpServletRequest request) {
        super(request);

        String categoryName = request.getParameter("category");
        bestSeller = (isValidName(categoryName)) ?
                categoryDao.findByName(categoryName) :
                categoryDao.findByCategoryId(1);
        selectedBestSellerBooks = bookDao.findByCategoryId(3);

        topRated = (isValidName(categoryName)) ?
                categoryDao.findByName(categoryName) :
                categoryDao.findByCategoryId(1);
        selectedTopRatedBooks = bookDao.findByCategoryId(6);

        newReleases = (isValidName(categoryName)) ?
                categoryDao.findByName(categoryName) :
                categoryDao.findByCategoryId(1);
        selectedNewReleasesBooks = bookDao.findByCategoryId(4);

    }


    private boolean isValidName(String categoryName) {

        return true;
    }

    public Category getbestSeller() {
        return bestSeller;
    }

    public Category getTopRated() {
        return topRated;
    }

    public Category getNewReleases() {
        return newReleases;
    }

    public List<Book> getSelectedBestSellerBooks() {
        return selectedBestSellerBooks;
    }

    public List<Book> getSelectedTopRatdeBooks() {
        return selectedTopRatedBooks;
    }

    public List<Book> getSelectedNewReleasesBooks() {
        return selectedNewReleasesBooks;
    }
}
