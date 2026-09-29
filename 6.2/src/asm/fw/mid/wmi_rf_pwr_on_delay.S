/* wmi_rf_pwr_on_delay @ 0x8e6e40, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_rf_pwr_on_delay
wmi_rf_pwr_on_delay:
	.global L_8e6e40
L_8e6e40:
	push_s blink
L_8e6e42:
	bl L_8c01e0
L_8e6e46:
	sub_s sp,sp,0x4
L_8e6e48:
	mov_s r14,r0
L_8e6e4a:
	mov_s r13,r1
L_8e6e4c:
	bl.d L_8c33d0
L_8e6e50:
	mov_s r15,r2
L_8e6e52:
	mov_s r1,r0
L_8e6e54:
	ldw_s r2,[r13,0x2]
L_8e6e56:
	mov_s r0,0x8004c8
L_8e6e5c:
	stw_s r2,[r0]
L_8e6e5e:
	ldw_s r2,[r13]
L_8e6e60:
	mov_s r0,0x8004c6
L_8e6e66:
	stw_s r2,[r0]
L_8e6e68:
	mov_s r2,0x0
L_8e6e6a:
	stb_s r2,[r1]
L_8e6e6c:
	st_s r2,[sp,0x0]
L_8e6e6e:
	mov_s r0,r14
L_8e6e70:
	mov_s r3,0x185d
L_8e6e76:
	mov r4,0x4
L_8e6e7a:
	mov_s r5,r15
L_8e6e7c:
	mov_s r6,r2
L_8e6e7e:
	bl.d L_8e4fc4
L_8e6e82:
	mov_s r7,r2
L_8e6e84:
	b.d L_8c024c
L_8e6e88:
	add_s sp,sp,0x4
L_8e6e8a:
	nop_s
