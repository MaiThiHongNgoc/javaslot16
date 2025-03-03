package com.example.project_library.entities;

import jakarta.persistence.*;

import java.util.Date;

@Table(name="loans")
@Entity
public class Loans {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(name = "book_id", nullable = false)
    private int book_id;

    @Column(name = "member_id", nullable = false)
    private int member_id;

    @Column(name = "borrow_date", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date borrow_date;

    @Column(name = "return_date")
    @Temporal(TemporalType.DATE)
    private Date return_date;

    @Column(name = "status", nullable = false)
    private String status; // Borrowed hoặc Returned

    public Loans() {
    }

    public Loans(int id, int book_id, int member_id, Date borrow_date, Date return_date, String status) {
        this.id = id;
        this.book_id = book_id;
        this.member_id = member_id;
        this.borrow_date = borrow_date;
        this.return_date = return_date;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public int getMember_id() {
        return member_id;
    }

    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }

    public Date getBorrow_date() {
        return borrow_date;
    }

    public void setBorrow_date(Date borrow_date) {
        this.borrow_date = borrow_date;
    }

    public Date getReturn_date() {
        return return_date;
    }

    public void setReturn_date(Date return_date) {
        this.return_date = return_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
