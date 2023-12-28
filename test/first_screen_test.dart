import 'package:flutter_test/flutter_test.dart';
import 'package:suitmedia/utils/utility.dart';

void main() {
  group('Palindrome Test', () {
    test('SuitMedia - 1 returns true', () {
      expect(isPalindrome('kasur rusak'), true);
    });

    test('SuitMedia - 2 returns true', () {
      expect(isPalindrome('step on no pets'), true);
    });

    test('SuitMedia - 3 returns true', () {
      expect(isPalindrome('put it up'), true);
    });

    test('SuitMedia - 4 returns false', () {
      expect(isPalindrome('suitmedia'), false);
    });

    test('Empty string is palindrome', () {
      expect(isPalindrome(''), true);
    });

    test('Single character is palindrome returns true', () {
      expect(isPalindrome('a'), true);
    });

    test('Palindrome string with special characters returns true', () {
      expect(isPalindrome('A man, a plan, a canal, Panama!'), true);
    });

    test('Palindrome string with numbers returns true', () {
      expect(isPalindrome('12321'), true);
    });

    test('Non-palindrome string with numbers returns false', () {
      expect(isPalindrome('12345'), false);
    });

    test('Palindrome with Numbers and Symbols', () {
      expect(isPalindrome('1\$2\$3\$2\$1'), true);
    });

    test('Non-palindrome with Numbers and Symbols', () {
      expect(isPalindrome('123@456'), false);
    });

    test('Edge Case: Very Long Palindrome String', () {
      final longPalindrome = 'A man, a plan, a canal, Panama...' * 1000;
      expect(isPalindrome(longPalindrome), true);
    });

    test('Edge Case: Very Long Non-palindrome String', () {
      final longNonPalindrome = 'abcde...' * 1000;
      expect(isPalindrome(longNonPalindrome), false);
    });

    test('Edge Case: Palindrome String with Unicode Characters', () {
      expect(isPalindrome('😀😃😄😃😀'), true);
    });
  });
}
