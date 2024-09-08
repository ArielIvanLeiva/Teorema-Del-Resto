	.text
	.org 0x0000

	add x2, xzr, xzr
loop:
	add x0, x0, x17
	add x2, x2, x1
	sub x3, x2, x16
	cbz x3, end
	cbz xzr, loop
end:
	add x9, xzr, xzr
	stur x0, [x9, #0]

infloop:
	cbz xzr, infloop

