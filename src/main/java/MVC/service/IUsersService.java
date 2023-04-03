package MVC.service;

import MVC.model.Users;

import java.util.List;

public interface IUsersService {
    List<Users> findAll();

    int creat(Users users);

    Users findAll(int id);

    int edit(Users users);

    int del(int id);

    List<Users> listUserNS();

    Users kiemtra(String username, String password);

    int numAll();
}
