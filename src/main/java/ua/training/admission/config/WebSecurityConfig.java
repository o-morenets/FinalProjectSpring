package ua.training.admission.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import ua.training.admission.service.UserDetailsServiceImpl;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    private final UserDetailsServiceImpl userDetailsService;

    private final DataSource dataSource;

    @Autowired
    public WebSecurityConfig(UserDetailsServiceImpl userDetailsService, DataSource dataSource) {
        this.userDetailsService = userDetailsService;
        this.dataSource = dataSource;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        /* The pages does not require login */
        http.authorizeRequests()
                .antMatchers("/", "/login", "/signup").permitAll();

        /* ROLE_USER */
        http.authorizeRequests()
                .antMatchers(HttpMethod.GET, "/users/{userId}")
                .access("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')");

        /* ROLE_ADMIN */
        http.authorizeRequests()
                .antMatchers("/users/*")
                .access("hasRole('ROLE_ADMIN')");

		/*
		 When the user has logged in as XX.
		 But access a page that requires role YY,
		 AccessDeniedException will be thrown.
		*/
        http.authorizeRequests()
                .and().exceptionHandling().accessDeniedPage("/403");

        /* Config for Login Form */
        http.authorizeRequests()
                .and().formLogin().loginPage("/login")
                .and().logout();

        /* Config Remember Me. */
        http.authorizeRequests()
                .and()
                .rememberMe().tokenRepository(this.persistentTokenRepository())
                .tokenValiditySeconds(20 * 60); // 20 min
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {

		/*
		 Setting Service to find User in the database.
		 And Setting PasswordEncoder
		*/
        auth
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder());
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // Token stored in Table (Persistent_Logins)
    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl db = new JdbcTokenRepositoryImpl();
        db.setDataSource(dataSource);
        return db;
    }
}