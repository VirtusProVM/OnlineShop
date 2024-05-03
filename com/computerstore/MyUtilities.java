package com.computerstore;

import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;

public class MyUtilities {
    
    public static void loadCountries(HttpServletRequest request) {
        String[] countires = Locale.getISOCountries();
        
        Map<String, String> mapCountries = new TreeMap<>();
        
        for(String countryCode: countires) {
            Locale locale = new Locale("", countryCode);
            String code = locale.getCountry();
            String  name = locale.getDisplayCountry();
            
            mapCountries.put(name, code);
        }
        
        request.setAttribute("mapCountries", mapCountries);
    }
}
