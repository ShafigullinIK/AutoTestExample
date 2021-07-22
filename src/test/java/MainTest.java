import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class MainTest {

    @Test
    public void testSum(){
        Assertions.assertEquals(7, Main.sum(2, 5));
    }
}
