/* ps_nonassoc_mgr__ps_evt_handler @ 0x8dd2ec, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_nonassoc_mgr::ps_evt_handler (ps_evt=%d, param=%d) - IGNORE
 * Зовёт сам: fw_log__emit2
 */
	.section .text.ps_nonassoc_mgr__ps_evt_handler,"ax",@progbits
	.global ps_nonassoc_mgr__ps_evt_handler
ps_nonassoc_mgr__ps_evt_handler:
L_8dd2ec:
	mov_s r3,r1
L_8dd2ee:
	mov_s r4,r2
L_8dd2f0:
	mov_s r2,0x1002480
L_8dd2f6:
	mov_s r0,0xe
L_8dd2f8:
	b.d L_8edff8
L_8dd2fc:
	mov_s r1,0x2
L_8dd2fe:
	nop_s
