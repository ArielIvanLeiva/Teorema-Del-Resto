	.text
	.org 0x0000

	add x3, xzr, xzr
loop1:
	stur x3, [x0, #0]
	add x0, x0, x8
	add x3, x3, x1
	sub x2, x3, x5
	cbz x2, end1
	cbz XZR, loop1
end1:

	add x0, xzr, xzr
	add x2, xzr, xzr
	add x4, xzr, xzr
loop2:
	ldur x3, [x2, #0]
	add x0, x0, x3
	add x2, x2, x8
	add x4, x4, x1
	sub x3, x4, x5
	cbz x3, end2
	cbz xzr, loop2
end2:
	stur x0, [x2, #0]

infloop:
	cbz xzr, infloop
