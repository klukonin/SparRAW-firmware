/* fw_check_mpy_build @ 0x8e80a8, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_check_mpy_build,"ax",@progbits
	.global fw_check_mpy_build
fw_check_mpy_build:
	.byte 0x0f
	.byte 0xec
	.global sub_8e80aa
sub_8e80aa:
L_8e80aa:
	nop_s
L_8e80ac:
	ldb r0,[0x800589]
L_8e80b4:
	sub.f r0,r0,0x1
L_8e80b8:
	beq L_8e8124
L_8e80bc:
	lr r0,[0x7b]
L_8e80c0:
	and r1,r0,0xff
L_8e80c8:
	sub.f 0x0,r1,0x1
L_8e80cc:
	beq L_8e80f4
L_8e80d0:
	sub.f 0x0,r1,0x4
L_8e80d4:
	beq L_8e80f4
L_8e80d8:
	flag 0x1
L_8e80dc:
	mov 0x0,0x0
L_8e80e0:
	mov 0x0,0x0
L_8e80e4:
	mov 0x0,0x0
L_8e80e8:
	mov 0x0,0x0
L_8e80ec:
	mov 0x0,0x0
L_8e80f0:
	mov 0x0,0x0
	.global L_8e80f4
L_8e80f4:
	lr r0,[0x7d]
L_8e80f8:
	and r1,r0,0xff
L_8e8100:
	sub.f 0x0,r1,0x0
L_8e8104:
	bne L_8e8124
L_8e8108:
	flag 0x1
L_8e810c:
	mov 0x0,0x0
L_8e8110:
	mov 0x0,0x0
L_8e8114:
	mov 0x0,0x0
L_8e8118:
	mov 0x0,0x0
L_8e811c:
	mov 0x0,0x0
L_8e8120:
	mov 0x0,0x0
	.global L_8e8124
L_8e8124:
	j [blink]
