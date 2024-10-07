import java.io.IOException;
import java.util.Arrays;
import java.util.Scanner;

public class Solution01 {
    public static void main(String[] args) throws IOException {
        final var s = new Solution();
        try (final var scanner = new Scanner(System.in)) {
            while (scanner.hasNextLine()) {
                final var line = scanner.nextLine().trim();
                final var arr = Arrays.stream(line
                        .replaceAll("\\[|\\]", "")
                        .split(","))
                        .mapToInt(Integer::parseInt)
                        .toArray();
                final var k = scanner.nextInt();
                if (scanner.hasNextLine())
                    scanner.nextLine();
                final var result = s.canArrange(arr, k);
                System.out.println(result);
            }
        }

    }
}

class Solution {
    public boolean canArrange(int[] arr, int k) {
        int[] remainder = new int[k];

        for (int i = 0; i < k; i++) {
            remainder[i] = 0;
        }

        for (int i = 0; i < arr.length; i++) {

            if (arr[i] < 0) {
                int num = arr[i];
                int modu = ((num % k) + k) % k;
                remainder[modu]++;
            } else {
                int modu = arr[i] % k;
                remainder[modu]++;
            }
        }

        if (remainder[0] % 2 != 0) {
            return false;
        }

        for (int i = 1; i <= k / 2; i++) {

            int complement = k - i;
            if (remainder[complement] != remainder[i]) {
                return false;
            }
        }

        return true;
    }
}
