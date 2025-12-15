package com.recruitment.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "companies")
@PrimaryKeyJoinColumn(name = "user_id")
public class Company extends User {

    @Column(name = "company_name", nullable = false)
    private String companyName;

    private String address;

    @OneToMany(mappedBy = "company", cascade = CascadeType.ALL)
    private List<JobOffer> jobOffers;

    public Company() {
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<JobOffer> getJobOffers() {
        return jobOffers;
    }

    public void setJobOffers(List<JobOffer> jobOffers) {
        this.jobOffers = jobOffers;
    }
}
