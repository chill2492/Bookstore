package business.customer;

import java.util.Calendar;
import java.util.Date;

public class CustomerForm {

    private String name;
    private String address;
    private String phone;
    private String email;
    private String ccNumber;
    private Date ccExpDate;
    private String ccMonth;
    private String ccYear;

    private boolean hasNameError;
    private boolean hasAddressError;
    private boolean hasPhoneError;
    private boolean hasEmailError;
    private boolean hasccNumberError;
    private boolean hasccExpDateError;


    public CustomerForm() {
        this("", "", "", "", "", "", "");
    }

    public CustomerForm(String name, String address, String phone, String email,
                        String ccNumber, String ccMonth, String ccYear) {
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.ccNumber = ccNumber;

        this.ccMonth = ccMonth;
        this.ccYear = ccYear;
        this.ccExpDate = getCcExpDate(ccMonth, ccYear);

        validate();
    }

    // Get methods for fields
    public String getName() {
        return name;
    }

    public String getPhone() {
        return phone;
    }

    public String getAddress() {
        return address;
    }

    public String getEmail() {
        return email;
    }

    public String getCcNumber() {
        return ccNumber;
    }

    public String getCcMonth() {
        return ccMonth;
    }

    public String getCcYear() {
        return ccYear;
    }

    public Date getCcExpDate(){
        return ccExpDate;
    }


    // hasError methods for fields
    public boolean getHasNameError() {
        return hasNameError;
    }

    public boolean getHasPhoneError() {
        return hasPhoneError;
    }

    public boolean getHasEmailError() {
        return hasEmailError;
    }

    public boolean getHasAddressError() {
        return hasAddressError;
    }

    public boolean getHasCcNumberError() {
        return hasccNumberError;
    }

    public boolean getHasCcExpDateError() {
        return hasccExpDateError;
    }


    public boolean getHasFieldError() {
        return hasNameError || hasPhoneError || hasAddressError ||
                hasEmailError || hasccNumberError || hasccExpDateError;

    }

    // error messages for fields
    public String getNameErrorMessage() {
        return "Valid name required (ex: Bilbo Baggins)";
    }

    public String getAddressErrorMessage() {
        return "Valid address required (ex: 123 Main Street)";
    }

    public String getPhoneErrorMessage() {
        return "Valid US phone number required (ex: 363-345-1276)";
    }

    public String getEmailErrorMessage() {
        return "Valid email address required (ex: eBookZone@gmail.com)";
    }

    public String getCcNumberErrorMessage() {
        return "Valid credit card number required (ex: 1111 2222 4444 1234)";
    }

    public String getCcExpDateErrorMessage() {
        return "Expiration date has passed. Valid expiration date required (ex: 2-February / 2020)";
    }


    private void validate() {
        if (name == null || name.equals("") || name.length() > 45) {
            hasNameError = true;
        }

        if (address == null || address.equals("") || address.length() > 45) {
            hasAddressError = true;
        }

        String digitOnlyPhone = (phone == null) ? "" : phone.replaceAll("[^0-9]", "");
        if (phone.equals("") || digitOnlyPhone.length() != 10) {
            hasPhoneError = true;
        }

        if (email == null || email.equals("") || !email.contains("@") || email.contains(" ") || email.endsWith(".")) {
            hasEmailError = true;
        }

        String digitOnlyCcNumber = (ccNumber == null) ? "" : ccNumber.replaceAll("[^0-9]", "");
        if (ccNumber.equals("") || (digitOnlyCcNumber.length() < 14 || digitOnlyCcNumber.length() > 16)) {
            hasccNumberError = true;
        }

        Date date = new Date();
        if (ccExpDate == null || ccExpDate.equals("") || ccExpDate.before(date)){
            hasccExpDateError = true;
        }

    }

    // Returns a Java date object with the specified month and year
    public Date getCcExpDate(String monthString, String yearString) {

        if (monthString == null || yearString == null || monthString.equals("") || yearString.equals("")) {
            return null;
        }

        try {
            Calendar calendar = Calendar.getInstance();
            calendar.clear();
            calendar.set(Calendar.MONTH, Integer.parseInt(monthString)-1);
            calendar.set(Calendar.YEAR, Integer.parseInt(yearString));
            calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE));
            return calendar.getTime();

        } catch (Exception e) {
            return null;
        }

    }
}
