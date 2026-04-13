package model;

import java.sql.Timestamp;

public class Customer {
    private int customer_id;
    private String first_name;
    private String last_name;
    private String gender;
    private String customer_email;
    private String customer_phoneNo;
    private String customer_dob;
    private String customer_address;
    private String customer_country;
    private String customer_license;
    private String customer_username;
    private String referral_code;
    private String password;
    private Timestamp created_at;

    // MANDATORY CONSTRUCTOR - This was missing and causing your error
    public Customer(int customer_id, String first_name, String last_name, String gender,
                    String customer_email, String customer_phoneNo, String customer_dob,
                    String customer_address, String customer_country, String customer_license,
                    String customer_username, String referral_code, String password, Timestamp created_at) {
        this.customer_id = customer_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.gender = gender;
        this.customer_email = customer_email;
        this.customer_phoneNo = customer_phoneNo;
        this.customer_dob = customer_dob;
        this.customer_address = customer_address;
        this.customer_country = customer_country;
        this.customer_license = customer_license;
        this.customer_username = customer_username;
        this.referral_code = referral_code;
        this.password = password;
        this.created_at = created_at;
    }

    // Getters
    public String getPassword() { return password; }
    public int getCustomer_id() { return customer_id; }
    public String getFirst_name() { return first_name; }
    public String getLast_name() { return last_name; }
    public String getCustomer_email() { return customer_email; }
    public String getCustomer_phoneNo() { return customer_phoneNo; }
    public String getCustomer_license() { return customer_license; }
    public String getCustomer_address() { return customer_address; }
    public String getCustomer_username() { return customer_username; }
    public String getCustomer_dob() { return customer_dob; }
    public String getCustomer_country() { return customer_country; }
    public String getGender() { return gender; }
    public String getReferral_code() { return referral_code; }
    public Timestamp getCreated_at() { return created_at; }
    public String getFullName() {
        return first_name + " " + last_name;
    }
}