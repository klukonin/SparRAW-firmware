/* tx_api__ctx_8041f0 @ 0x8d9f7c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__send_pair, low_sme__send_evt2sw, mbox__drain_operational, sysassert__wmi_lock_notice
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_api__ctx_8041f0
tx_api__ctx_8041f0:
	.global L_8d9f7c
L_8d9f7c:
	push_s blink
L_8d9f7e:
	ld_s r0,[gp,-0x78]
L_8d9f80:
	brne r0,0x1,L_8d9f8e
	.global L_8d9f84
L_8d9f84:
	mov_s r0,0x8041f0
L_8d9f8a:
	pop_s blink
L_8d9f8c:
	j_s [blink]
	.global L_8d9f8e
L_8d9f8e:
	mov_s r0,blink
L_8d9f90:
	mov_s r1,0x5e
L_8d9f92:
	bl.d L_8c9b28
L_8d9f96:
	bset_s r1,r1,0xc
L_8d9f98:
	b_s L_8d9f84
L_8d9f9a:
	nop_s
