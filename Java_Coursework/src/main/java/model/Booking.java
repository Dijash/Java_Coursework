package model;

import java.sql.Date;

public class Booking {
    private int bookingId;
    private String customerName;
    private String vehicleDetails;
    private String status;
    private Date startDate;
    private Date endDate;
    private String totalPrice; // Added
    private String numberPlate;

    // Constructor used by BookingDAO (Matches the 8 parameters)
    public Booking(int bookingId, String customerName, String vehicleDetails, String status,
                   Date startDate, Date endDate, String totalPrice, String numberPlate) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.vehicleDetails = vehicleDetails;
        this.status = status;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalPrice = totalPrice;
        this.numberPlate = numberPlate;
    }

    // Getters
    public int getBookingId() { return bookingId; }
    public String getCustomerName() { return customerName; }
    public String getVehicleDetails() { return vehicleDetails; }
    public String getStatus() { return status; }
    public Date getStartDate() { return startDate; }
    public Date getEndDate() { return endDate; }
    public String getTotalPrice() { return totalPrice; }
    public String getNumberPlate() { return numberPlate; }
}