/* uc_check_mpy_build @ 0x9378d0, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_check_mpy_build,"ax",@progbits
	.global uc_check_mpy_build
uc_check_mpy_build:
L_9378d0:
	ldb r0,[0x800698]
L_9378d8:
	sub.f r0,r0,0x1
L_9378dc:
	beq L_937948
L_9378e0:
	lr r0,[0x7b]
L_9378e4:
	and r1,r0,0xff
L_9378ec:
	sub.f 0x0,r1,0x1
L_9378f0:
	beq L_937918
L_9378f4:
	sub.f 0x0,r1,0x4
L_9378f8:
	beq L_937918
L_9378fc:
	flag 0x1
L_937900:
	mov 0x0,0x0
L_937904:
	mov 0x0,0x0
L_937908:
	mov 0x0,0x0
L_93790c:
	mov 0x0,0x0
L_937910:
	mov 0x0,0x0
L_937914:
	mov 0x0,0x0
	.global L_937918
L_937918:
	lr r0,[0x7d]
L_93791c:
	and r1,r0,0xff
L_937924:
	sub.f 0x0,r1,0x0
L_937928:
	bne L_937948
L_93792c:
	flag 0x1
L_937930:
	mov 0x0,0x0
L_937934:
	mov 0x0,0x0
L_937938:
	mov 0x0,0x0
L_93793c:
	mov 0x0,0x0
L_937940:
	mov 0x0,0x0
L_937944:
	mov 0x0,0x0
	.global L_937948
L_937948:
	j [blink]
