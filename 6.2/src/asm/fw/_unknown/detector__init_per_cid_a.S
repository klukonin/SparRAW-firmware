/* detector__init_per_cid_a @ 0x8d9134, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_loss_detectors__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, detector__init_common, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global detector__init_per_cid_a
detector__init_per_cid_a:
	.global L_8d9134
L_8d9134:
	push_s blink
L_8d9136:
	bl L_8c01e0
L_8d913a:
	mov_s r14,r0
L_8d913c:
	mov_s r13,r1
L_8d913e:
	brge.d r1,0x8,L_8d9164
L_8d9142:
	mov_s r15,r2
	.global L_8d9144
L_8d9144:
	stb r13,[r14, 0x30]
L_8d9148:
	st_s r15,[r14,0x34]
L_8d914a:
	mov_s r2,0x0
L_8d914c:
	st_s r2,[r14,0x3c]
L_8d914e:
	st_s r2,[r14,0x40]
L_8d9150:
	mov_s r0,r14
L_8d9152:
	mov r1,-0x1
L_8d9156:
	mov_s r3,0x1
L_8d9158:
	bl.d L_8d8fa0
L_8d915c:
	mov r4,0x5
L_8d9160:
	b L_8c024c
	.global L_8d9164
L_8d9164:
	mov_s r0,blink
L_8d9166:
	mov_s r1,0x147a
L_8d916c:
	bl L_8c9b28
L_8d9170:
	b_s L_8d9144
L_8d9172:
	nop_s
