/* link_stats__copy_entry @ 0x8cc368, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_link_maintain_cfg_read
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__copy_entry
link_stats__copy_entry:
	.global L_8cc368
L_8cc368:
	cmp_s r0,0x8
L_8cc36a:
	push_s blink
L_8cc36c:
	mov.cc r0,0x1
L_8cc370:
	bhs_s L_8cc38a
L_8cc372:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8cc374:
	add3_s r0,r0,r0
L_8cc376:
	add r2,r0,0x857060
L_8cc37e:
	mov_s r0,r1
L_8cc380:
	add_s r1,r2,0x4
L_8cc382:
	bl.d L_8c0380
L_8cc386:
	mov_s r2,0x24
L_8cc388:
	mov_s r0,0x0
	.global L_8cc38a
L_8cc38a:
	pop_s blink
L_8cc38c:
	j_s [blink]
L_8cc38e:
	nop_s
