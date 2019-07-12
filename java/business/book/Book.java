package business.book;

public class Book {

    /*
     * Private fields corresponding to the fields in the
     * book table of my database.
     */
    private final long bookId;
    private final String title;
    private final String author;
    private final int price;
    private final boolean isPublic;
    private final long categoryId;

    public Book(long bookId, String title, String author, int price, boolean isPublic, long categoryId) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.price = price;
        this.isPublic = isPublic;
        this.categoryId = categoryId;
    }


    public long getBookId() {
        return bookId;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public int getPrice() {
        return price;
    }

    public boolean getisPublic() {
        return isPublic;
    }

    public long getCategoryId() {
        return categoryId;
    }

    @Override
    public String toString() {
        return "Book{" +
                " bookId=" + bookId +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", price=" + price +
                ", isPublic=" + isPublic +
                ", categoryId=" + categoryId +
                '}';
    }
}
