return {
	-- arithmetic

	add = require("f.operator.add"),
	inc = require("f.operator.inc"),
	dec = require("f.operator.dec"),
	sub = require("f.operator.sub"),
	mul = require("f.operator.mul"),
	div = require("f.operator.div"),
	idiv = require("f.operator.idiv"),
	fdiv = require("f.operator.fdiv"),
	mod = require("f.operator.mod"),
	pow = require("f.operator.pow"),
	neg = require("f.operator.neg"),

	-- comparison

	lt = require("f.operator.lt"),
	le = require("f.operator.le"),
	gt = require("f.operator.gt"),
	ge = require("f.operator.ge"),
	eq = require("f.operator.eq"),
	ne = require("f.operator.ne"),

	-- logical

	land = require("f.operator.land"),
	lor = require("f.operator.lor"),
	lnot = require("f.operator.lnot"),
	ltruth = require("f.operator.ltruth"),

	-- string

	concat = require("f.operator.concat"),

	-- sequence

	length = require("f.operator.length"),
}
