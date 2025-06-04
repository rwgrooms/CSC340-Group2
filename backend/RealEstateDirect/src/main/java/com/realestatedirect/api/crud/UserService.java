package com.realestatedirect.api.crud;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import org.mindrot.jbcrypt.BCrypt;
@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    public User saveUser(User user) {
        User ret = user;
        String pass = ret.getPassword();
        if (pass != null && !pass.isEmpty()) {
            String hashed = BCrypt.hashpw(pass, BCrypt.gensalt());
            ret.setPassword(hashed);
        }
        return userRepository.save(ret);
    }

    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    public User updateUser(Long id, User updatedUser) {
        updatedUser.setUserId(id);
        return userRepository.save(updatedUser);
    }
}
