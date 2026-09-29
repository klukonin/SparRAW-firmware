/* discovery__ssid_matches @ 0x8e3220, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_is_ssid_approved
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcmp_fw, str__eq_n
 */
	.section .text.discovery__ssid_matches,"ax",@progbits
	.global discovery__ssid_matches
discovery__ssid_matches:
	.global L_8e3220
L_8e3220:
	push_s blink
L_8e3222:
	bl L_8c02c0
L_8e3226:
	mov_s r13,r0
L_8e3228:
	mov_s r15,r1
L_8e322a:
	mov_s r14,r2
L_8e322c:
	bl.d L_8d9ff8
L_8e3230:
	mov_s r1,0x0
L_8e3232:
	sub r1,r0,r13
L_8e3236:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e3238:
	cmp_s r0,0x0
L_8e323a:
	mov.eq r2,r14
L_8e323e:
	mov.ne r2,r1
L_8e3242:
	mov_s r0,r13
L_8e3244:
	bl.d L_8da014
L_8e3248:
	mov_s r1,r15
L_8e324a:
	b L_8c032c
L_8e324e:
	nop_s
