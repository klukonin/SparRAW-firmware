/* l2mgr__config_security @ 0x8ea510, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Config Security Mid[%d] configured: m_wpa_offload = %x, auth_mode = %x
 * Зовут его: bcon_ctrl__prepare_mid, l2_mgr__connect_setup
 * Зовёт сам: fw_log__emit3
 */
	.section .text.l2mgr__config_security,"ax",@progbits
	.global l2mgr__config_security
l2mgr__config_security:
	.global L_8ea510
L_8ea510:
	mov_s r6,r2
L_8ea512:
	st_s r1,[r0]
L_8ea514:
	st_s r2,[r0,0x4]
L_8ea516:
	st_s r3,[r0,0x8]
L_8ea518:
	st r4,[r0, 0xc]
L_8ea51c:
	mov_s r1,0x1
L_8ea51e:
	st_s r1,[r0,0x10]
L_8ea520:
	st r5,[r0, 0x18]
L_8ea524:
	ld_s r3,[r0,0x1c]
L_8ea526:
	mov_s r2,0x100efc8
L_8ea52c:
	mov_s r0,0xe
L_8ea52e:
	mov_s r1,0x2
L_8ea530:
	ldb_s r3,[r3,0x10]
L_8ea532:
	mov r4,r5
L_8ea536:
	b.d L_8ee034
L_8ea53a:
	mov r5,r6
L_8ea53e:
	nop_s
