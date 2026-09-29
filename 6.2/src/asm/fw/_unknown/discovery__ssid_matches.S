/* discovery__ssid_matches @ 0x8e82e0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_is_ssid_approved
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcmp_fw, str__eq_n
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery__ssid_matches
discovery__ssid_matches:
	.global L_8e82e0
L_8e82e0:
	push_s blink
L_8e82e2:
	bl L_8c01e0
L_8e82e6:
	mov_s r13,r0
L_8e82e8:
	mov_s r15,r1
L_8e82ea:
	mov_s r14,r2
L_8e82ec:
	bl.d L_8ddf30
L_8e82f0:
	mov_s r1,0x0
L_8e82f2:
	sub r1,r0,r13
L_8e82f6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e82f8:
	cmp_s r0,0x0
L_8e82fa:
	mov.eq r2,r14
L_8e82fe:
	mov.ne r2,r1
L_8e8302:
	mov_s r0,r13
L_8e8304:
	bl.d L_8ddf4c
L_8e8308:
	mov_s r1,r15
L_8e830a:
	b L_8c024c
L_8e830e:
	nop_s
