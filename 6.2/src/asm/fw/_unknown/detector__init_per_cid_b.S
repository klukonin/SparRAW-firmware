/* detector__init_per_cid_b @ 0x8d91b4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_loss_detectors__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, detector__init_common, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global detector__init_per_cid_b
detector__init_per_cid_b:
	.global L_8d91b4
L_8d91b4:
	push_s blink
L_8d91b6:
	bl L_8c01e0
L_8d91ba:
	mov_s r14,r0
L_8d91bc:
	mov_s r13,r1
L_8d91be:
	brge.d r1,0x8,L_8d91e4
L_8d91c2:
	mov_s r15,r2
	.global L_8d91c4
L_8d91c4:
	stb r13,[r14, 0x30]
L_8d91c8:
	st_s r15,[r14,0x34]
L_8d91ca:
	mov_s r2,0x0
L_8d91cc:
	st_s r2,[r14,0x4c]
L_8d91ce:
	st_s r2,[r14,0x50]
L_8d91d0:
	mov_s r0,r14
L_8d91d2:
	mov r1,-0x1
L_8d91d6:
	mov_s r3,0x1
L_8d91d8:
	bl.d L_8d8fa0
L_8d91dc:
	mov r4,0x5
L_8d91e0:
	b L_8c024c
	.global L_8d91e4
L_8d91e4:
	mov_s r0,blink
L_8d91e6:
	mov_s r1,0x1479
L_8d91ec:
	bl L_8c9b28
L_8d91f0:
	b_s L_8d91c4
L_8d91f2:
	nop_s
