/* link_lost_diag__dump_mac_rx @ 0x8ead38, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG MAC RX: CRC_OK=%d CRC_ERR= %d
 *   DEBUG MAC RX: PPDU Report 1: 0x%08x
 *   DEBUG MAC RX: PPDU Report 2: 0x%08x
 *   DEBUG MAC RX: PPDU Report 3: 0x%08x
 *   DEBUG MAC RX: PPDU Report 4: 0x%08x
 *   DEBUG MAC RX: UCODE 1st buffer Backdoor dump beginning at 0x%x:
 *   				0x%08x
 *   DEBUG MAC RX: UCODE 2nd buffer Backdoor dump beginning at 0x%x:
 * Зовут его: link_lost_diag__dump_all
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit2, get_p8003b0_04, get_p8003b0_08
 */
	.section .text.link_lost_diag__dump_mac_rx,"ax",@progbits
	.global link_lost_diag__dump_mac_rx
link_lost_diag__dump_mac_rx:
	.global L_8ead38
L_8ead38:
	push_s blink
L_8ead3a:
	bl L_8c02bc
L_8ead3e:
	bl L_8d9b24
L_8ead42:
	bl.d L_8d9b1c
L_8ead46:
	mov_s r16,r0
L_8ead48:
	mov_s r4,r0
L_8ead4a:
	mov_s r2,0x1001040
L_8ead50:
	mov_s r0,0x0
L_8ead52:
	mov_s r1,0x2
L_8ead54:
	bl.d L_8edff8
L_8ead58:
	mov_s r3,r16
L_8ead5a:
	mov_s r13,0x886e00
L_8ead60:
	ld_s r3,[r13,0x58]
L_8ead62:
	mov_s r2,0x1001064
L_8ead68:
	mov_s r0,0x0
L_8ead6a:
	mov_s r15,0x887000
L_8ead70:
	bl.d L_8edfcc
L_8ead74:
	mov_s r1,0x2
L_8ead76:
	ld_s r3,[r13,0x5c]
L_8ead78:
	mov_s r2,0x1001088
L_8ead7e:
	mov_s r0,0x0
L_8ead80:
	bl.d L_8edfcc
L_8ead84:
	mov_s r1,0x2
L_8ead86:
	ld_s r3,[r13,0x60]
L_8ead88:
	mov_s r2,0x10010ac
L_8ead8e:
	mov_s r0,0x0
L_8ead90:
	bl.d L_8edfcc
L_8ead94:
	mov_s r1,0x2
L_8ead96:
	ld_s r3,[r13,0x64]
L_8ead98:
	mov_s r2,0x10010d0
L_8ead9e:
	mov_s r0,0x0
L_8eada0:
	bl.d L_8edfcc
L_8eada4:
	mov_s r1,0x2
L_8eada6:
	mov_s r14,0x944000
L_8eadac:
	st.as 0x32000000,[r15,-0x8e]
L_8eadb4:
	mov_s r2,0x10010f4
L_8eadba:
	mov_s r0,0x0
L_8eadbc:
	mov_s r1,0x2
L_8eadbe:
	bl.d L_8edfcc
L_8eadc2:
	mov_s r3,r14
L_8eadc4:
	mov_s r13,0x18
	.global L_8eadc6
L_8eadc6:
	ld.ab r3,[r14,0x4]
L_8eadca:
	mov_s r2,0x1001134
L_8eadd0:
	mov_s r0,0x0
L_8eadd2:
	bl.d L_8edfcc
L_8eadd6:
	mov_s r1,0x2
L_8eadd8:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8eadda:
	brhs r13,0x1,L_8eadc6
L_8eadde:
	mov_s r13,0x944000
L_8eade4:
	st.as 0x32000001,[r15,-0x8e]
L_8eadec:
	mov_s r2,0x1001140
L_8eadf2:
	mov_s r0,0x0
L_8eadf4:
	mov_s r1,0x2
L_8eadf6:
	bl.d L_8edfcc
L_8eadfa:
	mov_s r3,r13
L_8eadfc:
	mov_s r14,0x18
	.global L_8eadfe
L_8eadfe:
	ld.ab r3,[r13,0x4]
L_8eae02:
	mov_s r2,0x1001134
L_8eae08:
	mov_s r0,0x0
L_8eae0a:
	bl.d L_8edfcc
L_8eae0e:
	mov_s r1,0x2
L_8eae10:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8eae12:
	brhs r14,0x1,L_8eadfe
L_8eae16:
	b L_8c0324
L_8eae1a:
	nop_s
