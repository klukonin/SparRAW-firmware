/* rfc__read_or_dead @ 0x8cae70, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc_read_calibrate, rf__identify_type, rfc__probe_modules, temp_sense__no_rf
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_rfc_read_rgf, hwd_rfc_write_verify
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__read_or_dead
rfc__read_or_dead:
	.global L_8cae70
L_8cae70:
	push_s blink
L_8cae72:
	push_s r13
L_8cae74:
	mov_s r0,0x0
L_8cae76:
	bl.d L_8d3588
L_8cae7a:
	mov r1,0x3e0
L_8cae7e:
	mov_s r13,r0
L_8cae80:
	breq r0,0xdeadbeef,L_8caea6
L_8cae88:
	bset r2,r13,0xf
L_8cae8c:
	mov_s r0,0x0
L_8cae8e:
	mov r1,0x3e0
L_8cae92:
	bl.d L_8d4468
L_8cae96:
	mov_s r3,0x6
L_8cae98:
	mov_s r0,0x0
L_8cae9a:
	mov r1,0x3e0
L_8cae9e:
	mov_s r2,r13
L_8caea0:
	bl.d L_8d4468
L_8caea4:
	mov_s r3,0x6
	.global L_8caea6
L_8caea6:
	b L_8c025c
L_8caeaa:
	nop_s
