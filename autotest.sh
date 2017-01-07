#!/bin/zsh
echo "GILDEDROSE REFACTORING TEST."
echo "Differences:"
ruby texttest_fixture.rb > gr_with_refactoring.txt
diff golden_master.txt gr_with_refactoring.txt
echo
echo "-end-"
