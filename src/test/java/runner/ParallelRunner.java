package runner;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.Assert.assertTrue;

@KarateOptions(
     features = "src/test/java/feature"
       // ,tags = {"@ignore"}
        )


public class ParallelRunner {


        @Test
        public void testParallel() {

            Results results = Runner.parallel(getClass(),5);
            generateReport(results.getReportDir());
            assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
            //if you dont want to run parallel your scripts, delete above 3 line code and uncomment below
          // generateReport("target/surefire-reports");
            //but not showing failed tests

        }

        public static void generateReport(String karateOutputPath) {
            Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
            List<String> jsonPaths = new ArrayList(jsonFiles.size());
            jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
            Configuration config = new Configuration(new File("target"), "karate-demo-project");
            ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
            reportBuilder.generateReports();
        }

    }

