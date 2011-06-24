use("ispec")

isOver = method(rows,
	columns = [rows column(0), rows column(1), rows column(2)]
	diagonals = [rows[0]@(0) + rows[1]@(1) + rows[2]@(2), rows[0]@(2) + rows[1]@(1) + rows[2]@(0)]
	patterns = rows + columns + diagonals
	
	patterns any?(winner?) || patterns all?(full?)
)

Mixins Enumerable column = method(index, self map([index..index]) inject(+))
Text @ = method(index, self[index..index])
Text winner? = method(self =~ #/(XXX)|(OOO)/)
Text full? = method(self chars none?(== " "))

describe("tictactoe game",
	it("is over when all fields are taken",
		isOver([
			"XOX",
			"OXO",
			"OXO"]) should == true
		isOver(["XXO", "OXX", "XOO"]) should == true
	)
	it("is not over when not all fields are taken",
		isOver([" O ", "OXO", "OXO"]) should == false
	)
	it("is over when a row is taken",
		isOver(["XXX", "   ", "   "]) should == true
		isOver(["   ", "XXX", "   "]) should == true
		isOver(["   ", "   ", "XXX"]) should == true

		isOver(["OOO", "   ", "   "]) should == true
		isOver(["   ", "OOO", "   "]) should == true
		isOver(["   ", "   ", "OOO"]) should == true
	)
	it("is over when a column is taken",
		isOver(["X  ", "X  ", "X  "]) should == true
		isOver([" X ", " X ", " X "]) should == true
		isOver(["  X", "  X", "  X"]) should == true
	
		isOver(["O  ", "O  ", "O  "]) should == true
		isOver([" O ", " O ", " O "]) should == true
		isOver(["  O", "  O", "  O"]) should == true
	)
	it("is over when a diagonal is taken",
		isOver(["O  ", " O ", "  O"]) should == true
		isOver(["O X", " O ", "  O"]) should == true
		isOver(["  X", " X ", "X  "]) should == true
	)
)