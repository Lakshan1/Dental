package com.Dental.model;

// A patient record. Patients don't log in, so no email/password - just the
// details the appointment needs: NIC, name, address, contact number.
// NIC is the unique identifier (multiple patients can share one phone number,
// e.g. family members), so it's what appointment booking looks patients up by.
public class Patient {
    private int id;
    private String nic;
    private String name;
    private String address;
    private String contactNumber;

    public Patient() {}

    public Patient(int id, String nic, String name, String address, String contactNumber) {
        this.id = id;
        this.nic = nic;
        this.name = name;
        this.address = address;
        this.contactNumber = contactNumber;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
}
