package com.techelevator.model;

public class Student {

    private Long student_id;
    private String username;
    private String firstName;
    private String lastName;

    public Student(String firstName, String lastName, Long student_id, String username) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.student_id = student_id;
        this.username = username;
    }

    public Long getStudent_id() {
        return student_id;
    }

    public void setStudent_id(Long student_id) {
        this.student_id = student_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
}
