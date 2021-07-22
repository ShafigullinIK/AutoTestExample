import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class MainTest {

    @Test
    public void testSum(){
        int actualValue = Main.sum(2, 5);
        Assertions.assertEquals(7, actualValue, "Ваш метод выдает 2 + 5 = " + actualValue);
    }
}
