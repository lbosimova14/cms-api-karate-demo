package runner;

import com.intuit.karate.junit5.Karate;

class FeatureRunner {
    
    @Karate.Test
    Karate testUsers() {
        return new Karate().feature("users").relativeTo(getClass());
    }

    @Karate.Test
    Karate metaweather() {
        return new Karate().feature("metaweather").relativeTo(getClass());
    }
    @Karate.Test
    Karate metaweather2() {
        return new Karate().feature("metaweather2").relativeTo(getClass());
    }

}
