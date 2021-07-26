import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class MainTest {

    @Test
    public void testSum() {
        int actualValue = Main.sum(4, 5);
        Assertions.assertEquals(9, actualValue, "Ваш метод выдает 4 + 5 = " + actualValue);
        int actualValueForNegative = Main.sum(-2, 5);
        Assertions.assertEquals(3, actualValue, "Ваш метод выдает -2 + 5 = " + actualValueForNegative);
    }
}
