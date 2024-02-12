package ua.training.admission.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import ua.training.admission.entity.Role;
import ua.training.admission.service.userDetailsServiceImpl.UserDetailsServiceImpl;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    private final PasswordEncoder passwordEncoder;
    private final UserDetailsServiceImpl userDetailsService;
    private final DataSource dataSource;

    @Autowired
    public WebSecurityConfig(PasswordEncoder passwordEncoder,
                             UserDetailsServiceImpl userDetailsService,
                             DataSource dataSource) {

        this.passwordEncoder = passwordEncoder;
        this.userDetailsService = userDetailsService;
        this.dataSource = dataSource;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/", "/signup").permitAll()

                .antMatchers("/css/**", "/jquery/**", "/js/**", "/img/**").permitAll()

                .antMatchers("/users/profile", "/users/{id}/speciality")
                .access("hasAuthority('USER')")

                .antMatchers("/users", "/users/", "/users/{id}/grades",
                        "/users/passGrade", "/users/ratingList")
                .access("hasAuthority('ADMIN')")

                .anyRequest().authenticated()

                .and().formLogin().loginPage("/login").permitAll()
                .and().logout().permitAll()

                .and().rememberMe()
//                .userDetailsService(this.userDetailsService) // cookie-based remember-me
                .tokenRepository(persistentTokenRepository()) // token-based remember-me
                .tokenValiditySeconds(15 * 60)

                .and().exceptionHandling().accessDeniedPage("/403");
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder);
    }

    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl db = new JdbcTokenRepositoryImpl();
        db.setDataSource(dataSource);

        return db;
    }
}