/* bootloader_version__log @ 0x8efe50, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Boot Loader version = %d.%d.%d
 * Зовут его: fw_boot__log_versions
 * Зовёт сам: fw_log__emit3, fw_ver__fill_from_regs
 */
	.section .text.bootloader_version__log,"ax",@progbits
	.global bootloader_version__log
bootloader_version__log:
	.global L_8efe50
L_8efe50:
	push_s blink
L_8efe52:
	sub_s sp,sp,0x8
L_8efe54:
	mov_s r0,sp
L_8efe56:
	add r1,sp,0x1
L_8efe5a:
	add r2,sp,0x2
L_8efe5e:
	bl.d L_8ebccc
L_8efe62:
	add_s r3,sp,0x4
L_8efe64:
	ldw r5,[sp, 0x4]
L_8efe68:
	mov_s r1,0x880a00
L_8efe6e:
	ldw r0,[sp, 0x2]
L_8efe72:
	st r5,[r1, 0xc]
L_8efe76:
	ldb r4,[sp, 0x1]
L_8efe7a:
	st_s r0,[r1,0x8]
L_8efe7c:
	ldb_s r3,[sp,0x0]
L_8efe7e:
	st r4,[r1, 0x4]
L_8efe82:
	st_s r3,[r1]
L_8efe84:
	mov_s r2,0x10016e8
L_8efe8a:
	mov_s r0,0x0
L_8efe8c:
	bl.d L_8ee034
L_8efe90:
	mov_s r1,0x2
L_8efe92:
	add_s sp,sp,0x8
L_8efe94:
	pop_s blink
L_8efe96:
	j_s [blink]
