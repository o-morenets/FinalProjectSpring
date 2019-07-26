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
    public WebSecurityConfig(PasswordEncoder passwordEncoder, UserDetailsServiceImpl userDetailsService, DataSource dataSource) {
        this.passwordEncoder = passwordEncoder;
        this.userDetailsService = userDetailsService;
        this.dataSource = dataSource;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
// TODO roles
        /* The pages does not require login */
        http.authorizeRequests()
                .antMatchers("/", "/signup").permitAll();

        /* Config for Login Form */
        http.authorizeRequests()
                .and().formLogin().loginPage("/login").permitAll()
                .and().logout().permitAll()
                .and().rememberMe().tokenRepository(this.persistentTokenRepository()).tokenValiditySeconds(20 * 60);

		/*
		    When the user has logged in as XX.
		    But access a page that requires role YY, AccessDeniedException will be thrown.
		*/
        http.authorizeRequests()
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