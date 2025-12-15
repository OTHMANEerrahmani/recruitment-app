package com.recruitment.service;

import com.recruitment.dao.JobOfferDAO;
import com.recruitment.entity.JobOffer;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class JobService {

    private JobOfferDAO jobOfferDAO = new JobOfferDAO();

    public List<JobOffer> getAllOffers() {
        return jobOfferDAO.findAll();
    }

    public void createOffer(JobOffer offer) {
        jobOfferDAO.save(offer);
    }

    /**
     * Calculates a matching score (0-100%) between candidate skills and job
     * requirements.
     */
    public int calculateMatchScore(String candidateSkills, String jobSkills) {
        if (candidateSkills == null || jobSkills == null || jobSkills.isEmpty()) {
            return 0;
        }

        Set<String> cSkills = Arrays.stream(candidateSkills.toLowerCase().split(","))
                .map(String::trim)
                .collect(Collectors.toSet());

        Set<String> jSkills = Arrays.stream(jobSkills.toLowerCase().split(","))
                .map(String::trim)
                .collect(Collectors.toSet());

        if (jSkills.isEmpty())
            return 100;

        long matchCount = jSkills.stream().filter(cSkills::contains).count();

        return (int) ((double) matchCount / jSkills.size() * 100);
    }
}
