package br.com.institutobuscalonge.domain.user;

public enum AuthRole {
    ADMIN("admin"),
    USER("user");

    private String role;

    AuthRole(String role) {
        this.role = role;
    }

    public String getRole() {
        return role;
    }
}
