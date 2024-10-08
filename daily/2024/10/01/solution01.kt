import java.util.Scanner

class Solution {
    fun canArrange(arr: IntArray, k: Int): Boolean {
        val remainder = IntArray(k) { 0 }
        for (num in arr) {
            val modu = ((num % k) + k) % k
            remainder[modu]++
        }
        if (remainder[0] % 2 != 0) {
            return false
        }
        for (i in 1 until k) {
            if (remainder[i] != remainder[k - i]) {
                return false
            }
        }
        return true
    }
}

fun main() {
    val s = Solution()
    val scanner = Scanner(System.`in`)

    while (scanner.hasNextLine()) {
        val line = scanner.nextLine().trim()
        val arr = line.replace("[\\[\\]]".toRegex(), "").split(",").map { it.toInt() }.toIntArray()
        val k = scanner.nextInt()
        if (scanner.hasNextLine()) scanner.nextLine()
        val result = s.canArrange(arr, k)
        println(result)
    }
}
