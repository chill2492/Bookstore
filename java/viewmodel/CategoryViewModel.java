package viewmodel;

import business.ApplicationContext;
import business.book.Book;
import business.book.BookDao;
import business.category.Category;
import business.category.CategoryDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Collection;
import java.util.List;

public class CategoryViewModel extends BaseViewModel {
    private Category selectedCategory;
    private List<Book> selectedCategoryBooks;

    BookDao bookDao = ApplicationContext.INSTANCE.getBookDao();
    CategoryDao categoryDao = ApplicationContext.INSTANCE.getCategoryDao();

    public CategoryViewModel(HttpServletRequest request) {
        super(request);

        String categoryName = request.getParameter("category");

        if (categoryName != null) {
            selectedCategory = (isValidName(categoryName) ? categoryDao.findByName(categoryName) : categoryDao.findByCategoryId(1));
            rememberSelectedCategory(session, selectedCategory);
            selectedCategoryBooks = bookDao.findByCategoryId(selectedCategory.getCategoryId());
            rememberSelectedCategoryBooks(session, selectedCategoryBooks);
        } else {
            selectedCategory = recallSelectedCategory(session);
            selectedCategoryBooks = recallSelectedCategoryBooks(session);
        }
    }

    private void rememberSelectedCategory(HttpSession session, Category selectedCategory) {
        session.setAttribute("selectedCategory", selectedCategory);
    }

    private List<Book> recallSelectedCategoryBooks(HttpSession session) {
        return (List<Book>) session.getAttribute("selectedCategoryBooks");
    }

    private Category recallSelectedCategory(HttpSession session) {
        return (Category) session.getAttribute("selectedCategory");
    }


    private void rememberSelectedCategoryBooks(HttpSession session, List<Book> selectedCategoryBooks) {
        session.setAttribute("selectedCategoryProducts", selectedCategoryBooks);
    }

    private boolean isValidName(String categoryName) {
        return (categoryName != null);
    }

    public Category getSelectedCategory() {
        return selectedCategory;
    }

    public List<Book> getSelectedCategoryBooks() {
        return selectedCategoryBooks;
    }
}

