/* bootloader_version__log @ 0x8f8184, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Boot Loader version = %d.%d.%d
 * Зовут его: fw_boot__log_versions
 * Зовёт сам: fw_log_emit3, mac__read_880a2c_38
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bootloader_version__log
bootloader_version__log:
	.global L_8f8184
L_8f8184:
	push_s blink
L_8f8186:
	sub_s sp,sp,0x10
L_8f8188:
	mov_s r0,sp
L_8f818a:
	add_s r1,sp,0x4
L_8f818c:
	add_s r2,sp,0x8
L_8f818e:
	bl.d L_8f3570
L_8f8192:
	add_s r3,sp,0xc
L_8f8194:
	ld r4,[sp, 0xc]
L_8f8198:
	mov_s r1,0x880a00
L_8f819e:
	ld_s r0,[sp,0x8]
L_8f81a0:
	st r4,[r1, 0xc]
L_8f81a4:
	ld_s r3,[sp,0x4]
L_8f81a6:
	st_s r0,[r1,0x8]
L_8f81a8:
	ld_s r2,[sp,0x0]
L_8f81aa:
	st_s r3,[r1,0x4]
L_8f81ac:
	st_s r2,[r1]
L_8f81ae:
	mov_s r1,0x10016b4
L_8f81b4:
	bl.d L_8dcd00
L_8f81b8:
	mov_s r0,0x20
L_8f81ba:
	add_s sp,sp,0x10
L_8f81bc:
	pop_s blink
L_8f81be:
	j_s [blink]
