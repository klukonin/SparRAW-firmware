/* ba_setup_sm__addba_session_success @ 0x8e9410, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::addba_session_success() : m_wsize_actual=%d
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit1
 */
	.section .text.ba_setup_sm__addba_session_success,"ax",@progbits
	.global ba_setup_sm__addba_session_success
ba_setup_sm__addba_session_success:
L_8e9410:
	push_s blink
L_8e9412:
	push_s r13
L_8e9414:
	mov_s r13,r0
L_8e9416:
	mov_s r2,0x1010354
L_8e941c:
	mov_s r0,0x5
L_8e941e:
	mov_s r1,0x2
L_8e9420:
	bl.d L_8edfcc
L_8e9424:
	ldb r3,[r13, 0x3d]
L_8e9428:
	mov_s r1,0x7
L_8e942a:
	ldw r4,[r13, 0x42]
L_8e942e:
	mov_s r2,0x0
L_8e9430:
	ld_s r0,[r13,0x44]
L_8e9432:
	bl.d L_8d6a1c
L_8e9436:
	ldb r3,[r13, 0x3d]
L_8e943a:
	.byte 0x05,0x07
