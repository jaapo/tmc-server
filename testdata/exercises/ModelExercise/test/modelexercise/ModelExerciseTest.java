package modelexercise;

import fi.helsinki.cs.tmc.testrunner.Points;
import org.junit.Test;
import static org.junit.Assert.*;

public class ModelExerciseTest {
    @Test
    @Points("5.6")
    public void testReturnTrue()
    {
        assertTrue(ModelExercise.returnTrue());
    }
}
