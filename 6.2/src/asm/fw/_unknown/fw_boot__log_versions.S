/* fw_boot__log_versions @ 0x8f90ac, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 * Зовёт сам: bootloader_version__log, fw_image_info__set_flavor, fw_version__log, fw_version__log_date
 * Глобалы (через gp): 0x80022f
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_boot__log_versions
fw_boot__log_versions:
	.global L_8f90ac
L_8f90ac:
	push_s blink
L_8f90ae:
	bl L_8f8184
L_8f90b2:
	ld_s r0,[gp,-0x124]
L_8f90b4:
	ld.as r1,[gp,-0x48]
L_8f90b8:
	ld.as r2,[gp,-0x47]
L_8f90bc:
	bl.d L_8f3414
L_8f90c0:
	ld.as r3,[gp,-0x4a]
L_8f90c4:
	ldb r4,[gp, 0xaa]
L_8f90c8:
	ldb r5,[gp, 0xac]
L_8f90cc:
	ldb_s r0,[gp,0xab]
L_8f90ce:
	ldb r1,[gp, 0xa9]
L_8f90d2:
	ldb r2,[gp, 0xa8]
L_8f90d6:
	bl.d L_8f33b8
L_8f90da:
	ldb r3,[gp, 0xa7]
L_8f90de:
	bl.d L_8f33ac
L_8f90e2:
	mov_s r0,0x2
L_8f90e4:
	pop_s blink
L_8f90e6:
	j_s [blink]
