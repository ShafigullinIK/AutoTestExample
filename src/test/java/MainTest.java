import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class MainTest {

    @Test
    public void testSum(){
        Assertions.assertEquals(6, Main.sum(1, 5));
    }
}
