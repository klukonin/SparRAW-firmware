/* vring_macq_delete__program_macq @ 0x8e5130, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_macq_delete_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcpy_fw, vring__write_macq_desc
 */
	.section .text.vring_macq_delete__program_macq,"ax",@progbits
	.global vring_macq_delete__program_macq
vring_macq_delete__program_macq:
	.global L_8e5130
L_8e5130:
	push_s blink
L_8e5132:
	bl.d L_8c02c0
L_8e5136:
	mov_s r2,0x2
L_8e5138:
	mov_s r13,r0
L_8e513a:
	mov_s r15,r1
L_8e513c:
	add3 r14,r0,0x8
L_8e5140:
	mov_s r3,0x0
L_8e5142:
	bl.d L_8c4768
L_8e5146:
	mov r4,0x4
L_8e514a:
	mov_s r0,r14
L_8e514c:
	mov_s r1,r15
L_8e514e:
	mov_s r2,0x2
L_8e5150:
	mov_s r3,0x3
L_8e5152:
	bl.d L_8c4768
L_8e5156:
	mov_s r4,r3
L_8e5158:
	mov_s r0,0x805c0c
L_8e515e:
	mov_s r1,r13
L_8e5160:
	bl.d L_8c0460
L_8e5164:
	mov_s r2,0x70
L_8e5166:
	b L_8c032c
L_8e516a:
	nop_s
