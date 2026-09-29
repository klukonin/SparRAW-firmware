/* WBE_DRIVER__pxe_isoc_in_dir_bypass @ 0x8efae8, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::pxe_isoc_in_dir_bypass: %d
 *   wbe_driver.cpp
 * Зовут его: WBE_DRIVER__ACTIVATING, tail_WBE_DRIVER__pxe_isoc_in_dir_bypass, tail_WBE_DRIVER__pxe_isoc_in_dir_bypass_8ef904
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.WBE_DRIVER__pxe_isoc_in_dir_bypass,"ax",@progbits
	.global WBE_DRIVER__pxe_isoc_in_dir_bypass
WBE_DRIVER__pxe_isoc_in_dir_bypass:
	.global L_8efae8
L_8efae8:
	push_s blink
L_8efaea:
	bl.d L_8c02b8
L_8efaee:
	mov_s r1,0x2
L_8efaf0:
	mov_s r15,r0
L_8efaf2:
	mov_s r2,0x1003a0c
L_8efaf8:
	mov_s r0,0xf
L_8efafa:
	bl.d L_8edfcc
L_8efafe:
	mov_s r3,r15
L_8efb00:
	mov_s r13,0x882d80
L_8efb06:
	ld r17,[r13, 0x54]
L_8efb0a:
	bclr.f r16,r15,0x0
L_8efb0e:
	mov_s r0,r17
L_8efb10:
	bic r0,r0,0x46
L_8efb14:
	st_s r0,[r13,0x54]
L_8efb16:
	ld_s r0,[r13,0x54]
L_8efb18:
	bset_s r0,r0,0x1f
L_8efb1a:
	st_s r0,[r13,0x54]
L_8efb1c:
	bne_s L_8efb54
	.global L_8efb1e
L_8efb1e:
	mov_s r14,0x882e00
L_8efb24:
	ld_s r0,[r14,0x8]
L_8efb26:
	asl_s r15,r15,0xe
L_8efb28:
	bclr_s r0,r0,0xe
L_8efb2a:
	or_s r0,r0,r15
L_8efb2c:
	st_s r0,[r14,0x8]
L_8efb2e:
	brne r16,0x0,L_8efb68
	.global L_8efb32
L_8efb32:
	ld_s r0,[r14,0x1c]
L_8efb34:
	bclr_s r0,r0,0xe
L_8efb36:
	or_s r0,r0,r15
L_8efb38:
	st_s r0,[r14,0x1c]
L_8efb3a:
	brne r16,0x0,L_8efb7c
	.global L_8efb3e
L_8efb3e:
	ld_s r0,[r14,0x6c]
L_8efb40:
	bclr_s r0,r0,0xe
L_8efb42:
	or_s r0,r0,r15
L_8efb44:
	st_s r0,[r14,0x6c]
L_8efb46:
	st r17,[r13, 0x54]
L_8efb4a:
	ld_s r0,[r13,0x54]
L_8efb4c:
	bset_s r0,r0,0x1f
L_8efb4e:
	st_s r0,[r13,0x54]
L_8efb50:
	b L_8c031c
	.global L_8efb54
L_8efb54:
	mov_s r0,blink
L_8efb56:
	mov_s r2,0x10032e4
L_8efb5c:
	mov_s r1,0xac
L_8efb5e:
	bl.d L_8c82c0
L_8efb62:
	mov r3,0x56d
L_8efb66:
	b_s L_8efb1e
	.global L_8efb68
L_8efb68:
	mov_s r0,blink
L_8efb6a:
	mov_s r2,0x10032e4
L_8efb70:
	mov_s r1,0xac
L_8efb72:
	bl.d L_8c82c0
L_8efb76:
	mov r3,0x56f
L_8efb7a:
	b_s L_8efb32
	.global L_8efb7c
L_8efb7c:
	mov_s r0,blink
L_8efb7e:
	mov_s r2,0x10032e4
L_8efb84:
	mov_s r1,0xac
L_8efb86:
	bl.d L_8c82c0
L_8efb8a:
	mov r3,0x571
L_8efb8e:
	b_s L_8efb3e
