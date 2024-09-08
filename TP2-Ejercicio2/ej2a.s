	.text
	.org 0x0000

	add x3, xzr, xzr
loop:
	stur x3, [x0, #0]
	add x0, x0, x8
	add x3, x3, x1
	sub x2, x3, x5
	cbz x2, end
	cbz XZR, loop
end:
	cbz XZR, end
