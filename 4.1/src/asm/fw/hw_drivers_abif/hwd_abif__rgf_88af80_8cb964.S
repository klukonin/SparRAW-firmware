/* hwd_abif__rgf_88af80_8cb964 @ 0x8cb964, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: lo_power_gc_ctrl
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_88af80_8cb964,"ax",@progbits
	.global hwd_abif__rgf_88af80_8cb964
hwd_abif__rgf_88af80_8cb964:
	.global L_8cb964
L_8cb964:
	st.a r16,[sp,-0x4]
L_8cb968:
	mov_s r16,r0
L_8cb96a:
	bic.f r0,r0,0x3f
L_8cb96e:
	push_s blink
L_8cb970:
	bne_s L_8cb992
	.global L_8cb972
L_8cb972:
	mov_s r2,0x88af80
L_8cb978:
	ld_s r1,[r2,0x34]
L_8cb97a:
	asl r0,r16,0x8
L_8cb97e:
	and r1,r1,0xffffc0ff
L_8cb986:
	or_s r0,r0,r1
L_8cb988:
	st_s r0,[r2,0x34]
L_8cb98a:
	pop_s blink
L_8cb98c:
	j_s.d [blink]
L_8cb98e:
	ld.ab r16,[sp,0x4]
	.global L_8cb992
L_8cb992:
	mov_s r0,blink
L_8cb994:
	mov_s r2,0x1019954
L_8cb99a:
	mov_s r1,0xac
L_8cb99c:
	bl.d L_8c82c0
L_8cb9a0:
	mov r3,0x206
L_8cb9a4:
	b_s L_8cb972
L_8cb9a6:
	nop_s
